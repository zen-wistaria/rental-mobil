import executeQuery from "../config/database.js";
import validate from "../validation/validate.js";
import {
    addCarsValidation,
    registerUserValidation,
    updateUserValidation,
    updatePasswordValidation,
} from "../validation/validations.js";
import bcrypt from "bcrypt";

const getCars = async (page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT * FROM Mobil LIMIT ? OFFSET ?",
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

const getOneCar = async (id) => {
    const query = await executeQuery({
        query: "SELECT * FROM Mobil WHERE id = ?",
        values: [id],
    });
    const result = JSON.parse(JSON.stringify(query));
    return result;
};

const addCars = async (request) => {
    const data = validate(addCarsValidation, request);
    if (data.error) {
        return data.error.details.map((d) => d.message).join(".\n");
    }
    const result = await executeQuery({
        query: "INSERT INTO Mobil (merk, model, tahun_produksi, warna, plat_nomor, nomor_stnk, harga) VALUES (?, ?, ?, ?, ?, ?, ?)",
        values: [
            data.merk,
            data.model,
            data.tahun_produksi,
            data.warna,
            data.plat_nomor,
            data.nomor_stnk,
            data.harga,
        ],
    });
    return result;
};

const editCars = async (request) => {
    const data = validate(addCarsValidation, request);

    if (data.error) {
        return data.error.details.map((d) => d.message).join(".\n");
    }

    const query = await executeQuery({
        query: "UPDATE Mobil SET merk = ?, model = ? , tahun_produksi = ?, warna = ?, plat_nomor = ?, nomor_stnk = ?, harga = ? WHERE id = ?",
        values: [
            data.merk,
            data.model,
            data.tahun_produksi,
            data.warna,
            data.plat_nomor,
            data.nomor_stnk,
            data.harga,
            data.id,
        ],
    });
    const result = JSON.parse(JSON.stringify(query));
    return result;
};

const delCars = async (id) => {
    const result = await executeQuery({
        query: "DELETE FROM Mobil WHERE id = ?",
        values: [id],
    });
    return result;
};

const getClients = async (page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT id,username,nama,email,nik,alamat,nomor_telepon,DATE_FORMAT(tgl_lahir, '%d-%m-%Y') as tgl_lahir FROM Users WHERE roles = 'client' LIMIT ? OFFSET ?",
        values: [sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Users",
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

const addClient = async (request) => {
    const data = validate(registerUserValidation, request);

    //jika validasi gagal
    if (data.error) {
        return data.error.details.map((d) => d.message).join(".\n");
    }

    // cek jika user sudah ada
    const user = await executeQuery({
        query: "SELECT email FROM Users WHERE email = ?",
        values: [data.email],
    });

    if (user.length > 0) {
        return "Pengguna dengan email ini sudah terdaftar";
    }

    // jika validasi sukses
    data.password = await bcrypt.hash(data.password, 10);
    const result = await executeQuery({
        query: "INSERT INTO Users (nama, nik, email, alamat, nomor_telepon, tgl_lahir, password, roles) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)",
        values: [
            data.nama,
            data.nik,
            data.email,
            data.alamat,
            data.nomor_telepon,
            data.tgl_lahir,
            data.password,
            data.roles,
        ],
    });
    return result;
};

const getOneClient = async (id) => {
    const query = await executeQuery({
        query: "SELECT *, DATE_FORMAT(tgl_lahir, '%Y-%m-%d') as tgl_lahir FROM Users WHERE id = ?",
        values: [id],
    });
    const result = JSON.parse(JSON.stringify(query));
    return result;
};

const editClient = async (request) => {
    const data = validate(updateUserValidation, request);

    if (data.error) {
        return data.error.details.map((d) => d.message).join(".\n");
    }

    const exits = await executeQuery({
        query: "SELECT email FROM Users WHERE email = ?",
        values: [data.email],
    });

    if (exits.length > 1) {
        return "Email sudah terdaftar";
    }

    const query = await executeQuery({
        query: "UPDATE Users SET nama = ?, nik = ? , email = ?, alamat = ?, nomor_telepon = ?, tgl_lahir = ? WHERE id = ?",
        values: [
            data.nama,
            data.nik,
            data.email,
            data.alamat,
            data.nomor_telepon,
            data.tgl_lahir,
            data.id,
        ],
    });
    const result = JSON.parse(JSON.stringify(query));
    return result;
};

const delClient = async (id) => {
    const result = await executeQuery({
        query: "DELETE FROM Users WHERE id = ?",
        values: [id],
    });
    return result;
};

const getBookings = async (page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT Booking.id,Booking.id_mobil,Booking.id_user,Booking.status,Booking.kode_booking,DATE_FORMAT(tgl_booking, '%d-%m-%Y %H:%i') as tgl_booking, DATE_FORMAT(tgl_mulai_sewa, '%d-%m-%Y') as tgl_mulai_sewa, DATE_FORMAT(tgl_selesai_sewa, '%d-%m-%Y') as tgl_selesai_sewa, DATEDIFF (tgl_selesai_sewa, tgl_mulai_sewa) as lama_sewa,Users.nama, Users.email,Users.nomor_telepon, Mobil.merk as merk, Mobil.model as model, Mobil.harga as harga FROM Booking LEFT OUTER JOIN Users ON Booking.id_user = Users.id LEFT OUTER JOIN Mobil ON Booking.id_mobil = Mobil.id ORDER BY Booking.id DESC LIMIT ? OFFSET ?",
        values: [sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Booking",
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

const setBookingStatus = async (bookingId, request) => {
    const result = await executeQuery({
        query: "UPDATE Booking SET status = ? WHERE id = ?",
        values: [request.status, bookingId],
    });

    // update mobil ke disewa
    if (request.status === "dikonfirmasi") {
        await executeQuery({
            query: "UPDATE Mobil SET status = 'disewa' WHERE id = ?",
            values: [request.id],
        });
    }

    // update mobil ke tersedia
    if (request.status === "selesai") {
        await executeQuery({
            query: "UPDATE Mobil SET status = 'tersedia' WHERE id = ?",
            values: [request.id_mobil],
        });

        await executeQuery({
            query: "INSERT INTO Transaksi (id_user, id_mobil, tgl_peminjaman, tgl_pengembalian, total_biaya) VALUES (?, ?, ?, ?, ?)",
            values: [
                request.id_user,
                request.id_mobil,
                request.tgl_peminjaman.split("-").reverse().join("-"),
                request.tgl_pengembalian.split("-").reverse().join("-"),
                request.total_biaya,
            ],
        });
    }
    return result;
};

const getTransactions = async (page) => {
    const sizeOfPage = 10;
    const offset = (page - 1) * sizeOfPage;
    const data = await executeQuery({
        query: "SELECT Transaksi.id,Transaksi.id_mobil,Transaksi.total_biaya,Transaksi.kode_transaksi,Transaksi.status,DATE_FORMAT(Transaksi.tgl_peminjaman, '%d-%m-%Y') as tgl_peminjaman, DATE_FORMAT(Transaksi.tgl_pengembalian, '%d-%m-%Y') as tgl_pengembalian, DATEDIFF (tgl_pengembalian, tgl_peminjaman) as lama_sewa,Users.nama, Users.email,Users.nomor_telepon, Mobil.merk as merk, Mobil.model as model FROM Transaksi LEFT OUTER JOIN Users ON Transaksi.id_user = Users.id LEFT OUTER JOIN Mobil ON Transaksi.id_mobil = Mobil.id ORDER BY Transaksi.id DESC LIMIT ? OFFSET ?",
        values: [sizeOfPage, offset],
    });

    const total = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Transaksi",
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
    // Cek password saat ini
    const currentPassword = data.password_current;
    const getPassword = await executeQuery({
        query: "SELECT password FROM Users WHERE id = ?",
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
        query: "UPDATE Users SET password = ? WHERE id = ?",
        values: [user.password, id],
    });
};

const getTotalClients = async () => {
    const query = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Users WHERE roles = 'client'",
    });
    const result = JSON.parse(JSON.stringify(query));
    return result[0].total;
};

const getTotalCars = async () => {
    const query = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Mobil",
    });
    const result = JSON.parse(JSON.stringify(query));
    return result[0].total;
};

const getTotalBookings = async () => {
    const query = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Booking",
    });
    const result = JSON.parse(JSON.stringify(query));
    return result[0].total;
};

const getTotalTransactions = async () => {
    const query = await executeQuery({
        query: "SELECT COUNT(id) AS total FROM Transaksi",
    });
    const result = JSON.parse(JSON.stringify(query));
    return result[0].total;
};

const getKode = async () => {
    const query = await executeQuery({
        query: "SELECT * FROM Kode",
    });
    const result = JSON.parse(JSON.stringify(query));
    return result;
};

const updateKode = async (id, data) => {
    const query = await executeQuery({
        query: "UPDATE Kode SET kode = ?, deskripsi = ? WHERE id = ?",
        values: [data.kode, data.deskripsi, id],
    });

    const result = JSON.parse(JSON.stringify(query));
    return result;
};

export default {
    getCars,
    addCars,
    getOneCar,
    editCars,
    delCars,
    getClients,
    addClient,
    getOneClient,
    editClient,
    delClient,
    getBookings,
    setBookingStatus,
    getTransactions,
    getCurrentUser,
    updateProfileUser,
    updatePassword,
    getTotalClients,
    getTotalBookings,
    getTotalCars,
    getTotalTransactions,
    getKode,
    updateKode,
};
