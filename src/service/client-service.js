import executeQuery from "../config/database.js";

const getCars = async (page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT * FROM Mobil LIMIT ? OFFSET ? ",
        values: [sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Mobil",
    });
    const result = JSON.parse(JSON.stringify(data));

    const totalPages = Math.ceil(total[0].total / sizeOfPage);
    const maxPagination = 4;
    const halfMaxPagination = Math.floor(maxPagination / 2);
    let startPage = Math.max(page - halfMaxPagination, 1);
    let endPage = startPage + maxPagination - 1;
    if (endPage > totalPages) {
        endPage = totalPages;
        startPage = Math.max(endPage - maxPagination + 1, 1);
    }

    return {
        data: result,
        total_data: total[0].total,
        paging: {
            current_page: page,
            next_page: page + 1,
            prev_page: page - 1,
            start_page: startPage,
            end_page: endPage,
            total_page: totalPages,
        },
    };
};

const bookingCars = async (request) => {
    const data = await executeQuery({
        query: "INSERT INTO Booking (id_user, id_mobil, tgl_mulai_sewa, tgl_selesai_sewa) VALUES (?, ?, ?, ?)",
        values: [
            request.id_user,
            request.id_mobil,
            request.tgl_mulai_sewa,
            request.tgl_selesai_sewa,
        ],
    });

    // update mobil status
    await executeQuery({
        query: "UPDATE Mobil SET status = 'disewa' WHERE id = ?",
        values: [request.id_mobil],
    });

    const result = JSON.parse(JSON.stringify(data));
    return result[0];
};

const getBooking = async (id_user, page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT Booking.id,Booking.id_mobil,Booking.kode_booking,Booking.status,DATE_FORMAT(tgl_booking, '%d-%m-%Y %H:%i') as tgl_booking, DATE_FORMAT(tgl_mulai_sewa, '%d-%m-%Y') as tgl_mulai_sewa, DATE_FORMAT(tgl_selesai_sewa, '%d-%m-%Y') as tgl_selesai_sewa, DATEDIFF (tgl_selesai_sewa, tgl_mulai_sewa) as lama_sewa, Mobil.merk, Mobil.model FROM Booking LEFT OUTER JOIN Mobil ON Booking.id_mobil = Mobil.id WHERE Booking.id_user = ? ORDER BY Booking.id DESC LIMIT ? OFFSET ? ",
        values: [id_user, sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Booking WHERE id_user = ?",
        values: [id_user],
    });

    const result = JSON.parse(JSON.stringify(data));

    const totalPages = Math.ceil(total[0].total / sizeOfPage);
    const maxPagination = 4;
    const halfMaxPagination = Math.floor(maxPagination / 2);
    let startPage = Math.max(page - halfMaxPagination, 1);
    let endPage = startPage + maxPagination - 1;
    if (endPage > totalPages) {
        endPage = totalPages;
        startPage = Math.max(endPage - maxPagination + 1, 1);
    }

    return {
        data: result,
        total_data: total[0].total,
        paging: {
            current_page: page,
            next_page: page + 1,
            prev_page: page - 1,
            start_page: startPage,
            end_page: endPage,
            total_page: totalPages,
        },
    };
};

const delBooking = async (bookingId, mobilId) => {
    const data = await executeQuery({
        query: "DELETE FROM Booking WHERE id = ?",
        values: [bookingId],
    });

    // update status mobil
    await executeQuery({
        query: "UPDATE Mobil SET status = 'tersedia' WHERE id = ?",
        values: [mobilId],
    });

    const result = JSON.parse(JSON.stringify(data));
    return result[0];
};

const getTransactions = async (id_user, page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT Transaksi.id,Transaksi.id_mobil,Transaksi.kode_transaksi,Transaksi.total_biaya,Transaksi.status,DATE_FORMAT(tgl_peminjaman, '%d-%m-%Y') as tgl_peminjaman, DATE_FORMAT(tgl_pengembalian, '%d-%m-%Y') as tgl_pengembalian,DATEDIFF (tgl_pengembalian, tgl_peminjaman) as lama_sewa, Mobil.merk, Mobil.model FROM Transaksi LEFT OUTER JOIN Mobil ON Transaksi.id_mobil = Mobil.id WHERE Transaksi.id_user = ? ORDER BY Transaksi.id DESC LIMIT ? OFFSET ? ",
        values: [id_user, sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Transaksi WHERE id_user = ?",
        values: [id_user],
    });

    const result = JSON.parse(JSON.stringify(data));

    const totalPages = Math.ceil(total[0].total / sizeOfPage);
    const maxPagination = 4;
    const halfMaxPagination = Math.floor(maxPagination / 2);
    let startPage = Math.max(page - halfMaxPagination, 1);
    let endPage = startPage + maxPagination - 1;
    if (endPage > totalPages) {
        endPage = totalPages;
        startPage = Math.max(endPage - maxPagination + 1, 1);
    }

    return {
        data: result,
        total_data: total[0].total,
        paging: {
            current_page: page,
            next_page: page + 1,
            prev_page: page - 1,
            start_page: startPage,
            end_page: endPage,
            total_page: totalPages,
        },
    };
};

const setTransactionsStatus = async (transactionsId, status) => {
    const data = await executeQuery({
        query: "UPDATE Transaksi SET status = ? WHERE id = ?",
        values: [status, transactionsId],
    });
    return data[0];
};

const getCurrentUser = async (id) => {
    const query = await executeQuery({
        query: "SELECT *, DATE_FORMAT(tgl_lahir, '%Y-%m-%d') as tgl_lahir FROM Users WHERE id = ?",
        values: [id],
    });
    const result = JSON.parse(JSON.stringify(query));
    return result;
};

const updateProfileUser = async (id, data) => {
    return await executeQuery({
        query: "UPDATE Users SET nama = ?, email = ?, alamat = ?, nomor_telepon = ?, tgl_lahir = ?, foto_profil = ? WHERE id = ?",
        values: [
            data.nama,
            data.email,
            data.alamat,
            data.nomor_telepon,
            data.tgl_lahir,
            data.foto_profil,
            id,
        ],
    });
};

const updatePassword = async (id, data) => {
    const user = validate(updatePasswordValidation, data);
    //jika validasi gagal
    if (user.error) {
        return user.error.details.map((e) => e.message).join(".\n");
    }

    user.password = await bcrypt.hash(data.password, 10);
    return await executeQuery({
        query: "UPDATE Users SET password = ? WHERE id = ?",
        values: [user.password, id],
    });
};

const getTotalCars = async () => {
    const query = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Mobil",
    });
    const result = JSON.parse(JSON.stringify(query));
    return result[0].total;
};
const getTotalBookings = async (id_user) => {
    const query = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Booking WHERE id_user = ?",
        values: [id_user],
    });
    const result = JSON.parse(JSON.stringify(query));
    return result[0].total;
};
const getTotalTransactions = async (id_user) => {
    const query = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Transaksi WHERE id_user = ?",
        values: [id_user],
    });
    const result = JSON.parse(JSON.stringify(query));
    return result[0].total;
};

export default {
    getCars,
    bookingCars,
    getBooking,
    delBooking,
    getTransactions,
    setTransactionsStatus,
    getCurrentUser,
    updateProfileUser,
    updatePassword,
    getTotalCars,
    getTotalBookings,
    getTotalTransactions,
};
