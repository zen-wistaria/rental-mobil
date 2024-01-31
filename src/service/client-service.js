import executeQuery from "../config/database.js";
import validate from "../validation/validate.js";
import { updatePasswordValidation } from "../validation/validations.js";
import bcrypt from "bcrypt";

const getCars = async (page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT * FROM mobil LIMIT ? OFFSET ? ",
        values: [sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM mobil",
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
        query: "INSERT INTO booking (id_user, id_mobil, tgl_mulai_sewa, tgl_selesai_sewa) VALUES (?, ?, ?, ?)",
        values: [
            request.id_user,
            request.id_mobil,
            request.tgl_mulai_sewa,
            request.tgl_selesai_sewa,
        ],
    });

    // update mobil status
    await executeQuery({
        query: "UPDATE mobil SET status = 'disewa' WHERE id = ?",
        values: [request.id_mobil],
    });

    const result = JSON.parse(JSON.stringify(data));
    return result[0];
};

const getBooking = async (id_user, page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT booking.id,booking.id_mobil,booking.kode_booking,booking.status,DATE_FORMAT(tgl_booking, '%d-%m-%Y %H:%i') as tgl_booking, DATE_FORMAT(tgl_mulai_sewa, '%d-%m-%Y') as tgl_mulai_sewa, DATE_FORMAT(tgl_selesai_sewa, '%d-%m-%Y') as tgl_selesai_sewa, DATEDIFF (tgl_selesai_sewa, tgl_mulai_sewa) as lama_sewa, mobil.merk, mobil.model FROM booking LEFT OUTER JOIN mobil ON booking.id_mobil = mobil.id WHERE booking.id_user = ? ORDER BY booking.id DESC LIMIT ? OFFSET ? ",
        values: [id_user, sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM booking WHERE id_user = ?",
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
        query: "DELETE FROM booking WHERE id = ?",
        values: [bookingId],
    });

    // update status mobil
    await executeQuery({
        query: "UPDATE mobil SET status = 'tersedia' WHERE id = ?",
        values: [mobilId],
    });

    const result = JSON.parse(JSON.stringify(data));
    return result[0];
};

const getTransactions = async (id_user, page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT transaksi.id,transaksi.id_mobil,transaksi.kode_transaksi,transaksi.total_biaya,transaksi.status,DATE_FORMAT(tgl_peminjaman, '%d-%m-%Y') as tgl_peminjaman, DATE_FORMAT(tgl_pengembalian, '%d-%m-%Y') as tgl_pengembalian,DATEDIFF (tgl_pengembalian, tgl_peminjaman) as lama_sewa, mobil.merk, mobil.model FROM transaksi LEFT OUTER JOIN mobil ON transaksi.id_mobil = mobil.id WHERE transaksi.id_user = ? ORDER BY transaksi.id DESC LIMIT ? OFFSET ? ",
        values: [id_user, sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM transaksi WHERE id_user = ?",
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

const setTransactionsStatus = async (userId, transactionsId, status) => {
    const data = await executeQuery({
        query: "UPDATE transaksi SET status = ? WHERE  id_user = ? AND id = ?",
        values: [status, userId, transactionsId],
    });
    return data[0];
};

const getCurrentUser = async (id) => {
    const query = await executeQuery({
        query: "SELECT *, DATE_FORMAT(tgl_lahir, '%Y-%m-%d') as tgl_lahir FROM users WHERE id = ?",
        values: [id],
    });
    const result = JSON.parse(JSON.stringify(query));
    return result;
};

const updateProfileUser = async (id, data) => {
    return await executeQuery({
        query: "UPDATE users SET nama = ?, email = ?, alamat = ?, nomor_telepon = ?, tgl_lahir = ?, foto_profil = ? WHERE id = ?",
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
    // Cek password saat ini
    const currentPassword = data.password_current;
    const getPassword = await executeQuery({
        query: "SELECT password FROM users WHERE id = ?",
        values: [id],
    });
    const checkCurrentPassword = JSON.parse(JSON.stringify(getPassword));
    const check = await bcrypt.compare(
        currentPassword,
        checkCurrentPassword[0].password
    );

    if (!check) {
        return "Password saat ini tidak sesuai";
    }

    // validasi password dan konfirmasi password
    const user = validate(updatePasswordValidation, data);

    //jika validasi gagal
    if (user.error) {
        return user.error.details.map((e) => e.message).join(".\n");
    }

    user.password = await bcrypt.hash(data.password, 10);
    return await executeQuery({
        query: "UPDATE users SET password = ? WHERE id = ?",
        values: [user.password, id],
    });
};

const getTotalCars = async () => {
    const query = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM mobil",
    });
    const result = JSON.parse(JSON.stringify(query));
    return result[0].total;
};
const getTotalBookings = async (id_user) => {
    const query = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM booking WHERE id_user = ?",
        values: [id_user],
    });
    const result = JSON.parse(JSON.stringify(query));
    return result[0].total;
};
const getTotalTransactions = async (id_user) => {
    const query = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM transaksi WHERE id_user = ?",
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
