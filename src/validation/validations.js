import Joi from "joi";

const registerUserValidation = Joi.object({
    nama: Joi.string().max(150).required().messages({
        "string.base": "Nama harus berupa string",
        "string.max": "Maksimal 150 karakter",
        "any.required": "Nama tidak boleh kosong",
    }),
    nik: Joi.string().max(16).required().messages({
        "string.base": "NIK harus berupa string",
        "string.max": "Maksimal 16 karakter",
        "any.required": "NIK tidak boleh kosong",
    }),
    email: Joi.string().email().required().messages({
        "string.base": "Email harus berupa string",
        "string.email": "Email tidak valid",
        "any.required": "Email tidak boleh kosong",
    }),
    alamat: Joi.string().messages({
        "string.base": "Alamat harus berupa string",
    }),
    nomor_telepon: Joi.string().max(20).required().messages({
        "string.base": "Nomor telepon harus berupa string",
        "string.max": "Maksimal 20 karakter",
        "any.required": "Nomor telepon tidak boleh kosong",
    }),
    tgl_lahir: Joi.date().messages({
        "date.base": '"Tgl lahir" harus berupa date',
    }),
    password: Joi.string().min(8).max(20).required().messages({
        "string.base": "Password harus berupa string",
        "string.min": "Minimal 8 karakter",
        "string.max": "Maksimal 20 karakter",
        "any.required": "Password tidak boleh kosong",
    }),
    konfirmasi_password: Joi.any()
        .equal(Joi.ref("password"))
        .required()
        .label("Konfirmasi password")
        .options({ messages: { "any.only": "{{#label}} does not match" } }),
    roles: Joi.string().required(),
});

const updateUserValidation = Joi.object({
    nama: Joi.string().max(150).required(),
    nik: Joi.string().max(16).required(),
    email: Joi.string().email().required(),
    alamat: Joi.string(),
    nomor_telepon: Joi.string().max(20).required(),
    tgl_lahir: Joi.date(),
    password: Joi.string().min(8).max(20),
    id: Joi.any(),
});

const loginUserValidation = Joi.object({
    email: Joi.string().required(),
    password: Joi.string().required(),
});

const addCarsValidation = Joi.object({
    merk: Joi.string().max(50).required(),
    model: Joi.string().max(50).required(),
    tahun_produksi: Joi.number().required(),
    warna: Joi.string().max(20).required(),
    plat_nomor: Joi.string().max(10).required(),
    nomor_stnk: Joi.number().unsafe().required(),
    harga: Joi.number().required(),
    id: Joi.any(),
});

export {
    registerUserValidation,
    updateUserValidation,
    loginUserValidation,
    addCarsValidation,
};
