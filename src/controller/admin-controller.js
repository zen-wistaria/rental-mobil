import adminService from "../service/admin-service.js";
const index = async (req, res) => {
    console.log(req.session);
    res.render("admin/index", {
        title: "Admin Dashboard",
        title_page: "Dashboard",
        path: req.path,
        user: req.session.user,
    });
};

// Mobil
const cars = async (req, res) => {
    let msg;
    try {
        const page = parseInt(req.query.page) || 1;
        const result = await adminService.getCars(page);
        res.render("admin/cars", {
            title: "Admin Cars",
            title_page: "Mobil",
            path: req.path,
            data: result,
            msg: msg,
            user: req.session.user,
        });
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};
const addCar = async (req, res) => {
    let msg;
    try {
        // handle GET request
        if (req.method === "GET") {
            res.render("admin/cars-add-form", {
                title: "Admin Mobil",
                title_page: "Tambah Mobil",
                path: req.path,
                msg: msg,
                user: req.session.user,
            });
            return;
        }

        // handle POST request
        const result = await adminService.addCars(req.body);

        if (result?.affectedRows === 1) {
            msg = "Berhasil ditambahkan !!";
        } else {
            msg = result;
        }
        res.render("admin/cars-add-form", {
            title: "Admin Mobil",
            title_page: "Tambah Mobil",
            path: req.path,
            msg: msg,
            user: req.session.user,
        });
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};

const editCar = async (req, res) => {
    let msg;
    try {
        // handle GET request
        if (req.method === "GET") {
            const result = await adminService.getOneCar(req.query.id);
            res.render("admin/cars-edit-form", {
                title: "Admin Mobil",
                title_page: "Edit Mobil",
                path: req.path,
                msg: msg,
                data: result,
                user: req.session.user,
            });
            return;
        }

        // handle PUT request
        const result = await adminService.editCars(req.body);
        res.redirect("/admin/dashboard/cars");
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};
const delCar = async (req, res) => {
    try {
        const result = await adminService.delCars(req.query.id);
        res.redirect("/admin/dashboard/cars");
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};

// Pelanggan
const clients = async (req, res) => {
    let msg;
    try {
        const page = parseInt(req.query.page) || 1;
        const result = await adminService.getClients(page);
        res.render("admin/clients", {
            title: "Admin Clients",
            title_page: "Pelanggan",
            path: req.path,
            data: result,
            msg: msg,
            user: req.session.user,
        });
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};
const addClient = async (req, res) => {
    let msg;
    try {
        // handle GET request
        if (req.method === "GET") {
            res.render("admin/clients-add-form", {
                title: "Admin Mobil",
                title_page: "Tambah Pelanggan",
                path: req.path,
                msg: msg,
                user: req.session.user,
            });
            return;
        }

        // handle POST request
        req.body.konfirmasi_password = req.body.password;
        req.body.roles = "client";
        const result = await adminService.addClient(req.body);

        if (result?.affectedRows === 1) {
            msg = "Berhasil ditambahkan !!";
        } else {
            msg = result;
        }
        res.render("admin/clients-add-form", {
            title: "Admin Mobil",
            title_page: "Tambah Pelanggan",
            path: req.path,
            msg: msg,
            user: req.session.user,
        });
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};

const editClient = async (req, res) => {
    let msg;
    try {
        // handle GET request
        if (req.method === "GET") {
            const result = await adminService.getOneClient(req.query.id);
            res.render("admin/clients-edit-form", {
                title: "Admin Pelanggan",
                title_page: "Edit Pelanggan",
                path: req.path,
                msg: msg,
                data: result,
                user: req.session.user,
            });
            return;
        }

        // handle PATCH request
        const result = await adminService.editClient(req.body);
        res.redirect("/admin/dashboard/clients");
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};
const delClient = async (req, res) => {
    try {
        await adminService.delClient(req.query.id);
        res.redirect("/admin/dashboard/clients");
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};

const forms = async (req, res) => {
    res.render("admin/forms", {
        title: "Admin Forms",
        title_page: "Forms",
        path: req.path,
    });
};

const profile = async (req, res) => {
    res.render("admin/profile", {
        title: "Admin Profile",
        title_page: "Profile",
        path: req.path,
    });
};

export default {
    index,
    cars,
    addCar,
    editCar,
    delCar,
    clients,
    addClient,
    editClient,
    delClient,
    forms,
    profile,
};
