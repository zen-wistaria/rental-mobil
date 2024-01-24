import executeQuery from "../config/database.js";
import validate from "../validation/validate.js";
import {
    addCarsValidation,
    registerUserValidation,
    updateUserValidation,
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
};
