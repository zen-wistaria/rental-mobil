import {
    loginUserValidation,
    registerUserValidation,
} from "../validation/validations.js";
import validate from "../validation/validate.js";
import executeQuery from "../config/database.js";
import bcrypt from "bcrypt";

const login = async (request) => {
    const data = validate(loginUserValidation, request);

    // jika validasi gagal
    if (data.error) {
        return data.error.details.map((d) => d.message).join(".\n");
    }

    const user = await executeQuery({
        query: "SELECT * FROM users WHERE email = ? OR username = ?",
        values: [data.email, data.email],
    });

    // cek apakah user ada
    if (user.length === 0) {
        return "Username atau password salah";
    }

    data.password = await bcrypt.compare(data.password, user[0].password);
    if (!data.password) {
        return "Username atau password salah";
    }
    const result = JSON.parse(JSON.stringify(user));
    return result[0];
};

const register = async (request) => {
    const data = validate(registerUserValidation, request);

    //jika validasi gagal
    if (data.error) {
        return data.error.details.map((d) => d.message).join(".\n");
    }

    // cek jika user sudah ada
    const user = await executeQuery({
        query: "SELECT email FROM users WHERE email = ?",
        values: [data.email],
    });

    if (user.length > 0) {
        return "Pengguna dengan email ini sudah terdaftar";
    }

    // jika validasi sukses
    data.password = await bcrypt.hash(data.password, 10);
    const result = await executeQuery({
        query: "INSERT INTO users (nama, nik, email, alamat, nomor_telepon, tgl_lahir, password, roles) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)",
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

export default {
    register,
    login,
};
