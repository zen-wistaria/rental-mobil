import adminService from "../service/admin-service.js";

const dashboard = async (req, res) => {
    const total_client = await adminService.getTotalClients();
    const total_booking = await adminService.getTotalBookings();
    const total_transaction = await adminService.getTotalTransactions();
    const total_cars = await adminService.getTotalCars();
    const result = {
        total_client,
        total_booking,
        total_transaction,
        total_cars,
    };
    let msg;
    res.render("admin/dashboard", {
        title: "Admin Dashboard",
        title_page: "Dashboard",
        path: req.path,
        data: result,
        msg: msg,
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
        res.redirect("/admin/cars");
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
        res.redirect("/admin/cars");
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
        res.redirect("/admin/clients");
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
        res.redirect("/admin/clients");
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};

const bookings = async (req, res) => {
    let msg;
    try {
        // handle GET method
        if (req.method === "GET") {
            const page = parseInt(req.query.page) || 1;
            const result = await adminService.getBookings(page);
            res.render("admin/bookings", {
                title: "Admin Bookings",
                title_page: "Booking",
                path: req.path,
                data: result,
                msg: msg,
                user: req.session.user,
            });
            return;
        }

        // handle PATCH method
        const bookingId = req.query.id;
        const result = await adminService.setBookingStatus(bookingId, req.body);
        res.redirect("/admin/booking");
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};

const transactions = async (req, res) => {
    let msg;
    try {
        const page = parseInt(req.query.page) || 1;
        const result = await adminService.getTransactions(page);
        res.render("admin/transactions", {
            title: "Admin Transactions",
            title_page: "Transaksi",
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

const setTransactionsStatus = async (req, res) => {
    try {
        const transactionsId = req.query.id;
        const status = req.body.status;
        const result = await adminService.setTransactionsStatus(
            transactionsId,
            status
        );
        res.redirect("/admin/transactions");
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};

const profile = async (req, res) => {
    let msg;
    try {
        // handle GET method
        if (req.method === "GET") {
            const result = await adminService.getCurrentUser(
                req.session.user.id
            );
            res.render("admin/profile", {
                title: "Admin Profil",
                title_page: "Profil",
                path: req.path,
                data: result,
                msg: msg,
                user: req.session.user,
            });
            // .sendFile("../files/profile" + result.foto_profil);
            return;
        }

        // handle PATCH method
        console.log(req.body, req.file);
        const result = await adminService.updateProfileUser(
            req.session.user.id,
            req.body
        );
        res.redirect("/admin/profile");
    } catch (error) {
        console.log(error);
        res.render("500", {
            title: "Server Error",
        });
    }
};

const profileSetting = async (req, res) => {
    let msg;
    try {
        // handle GET method
        if (req.method === "GET") {
            const result = await adminService.getCurrentUser(
                req.session.user.id
            );
            res.render("admin/profile-setting", {
                title: "Admin Profil Setting",
                title_page: "Profil Setting",
                path: req.path,
                data: result,
                msg: msg,
                user: req.session.user,
            });
            return;
        }

        // handle PATCH method
        if (req.body.password_current) {
            // update password
            const result = await adminService.updatePassword(
                req.session.user.id,
                req.body
            );
            if (result.affectedRows === 1) {
                msg = "Password berhasil di update !!";
            } else {
                msg = result;
            }
        } else {
            // update profile
            const update = await adminService.updateProfileUser(
                req.session.user.id,
                req.body
            );

            if (update.affectedRows === 1) {
                msg = "Data berhasil di update !!";
            } else {
                msg = "Data gagal di update !!";
            }
        }

        const result = await adminService.getCurrentUser(req.session.user.id);
        res.render("admin/profile-setting", {
            title: "Admin Profil Setting",
            title_page: "Profil Setting",
            path: req.path,
            data: result,
            msg: msg,
            user: req.session.user,
        });
    } catch (error) {
        console.log(error);
        res.render("500", {
            title: "Server Error",
        });
    }
};

const settings = async (req, res) => {
    let msg;
    try {
        // handle GET method
        if (req.method === "GET") {
            // 1 Transaksi, 2 Booking
            if (Object.keys(req.params).length > 0) {
                if (req.params.kode === "1" || req.params.kode === "2") {
                    const result = await adminService.getHistoryKode(
                        req.params.kode
                    );
                    if (result.error) {
                        res.json(result.error?.sqlMessage);
                        return;
                    }
                    res.json(result);
                    return;
                } else {
                    res.render("404");
                    return;
                }
            }
            // get kode setting
            const result = await adminService.getKode();
            res.render("admin/settings", {
                title: "Admin Settings",
                title_page: "Settings",
                path: req.path,
                data: result,
                msg: msg,
                user: req.session.user,
            });
            return;
        }

        // handle PATCH method
        // update kode
        if (req.query.kode) {
            const id_kode = req.query.kode;
            const data = await adminService.updateKode(id_kode, req.body);
            if (data.affectedRows === 1) {
                msg = "Kode berhasil di update !!";
            } else {
                msg = "Kode gagal di update !!";
            }

            const result = await adminService.getKode();
            res.render("admin/settings", {
                title: "Admin Settings",
                title_page: "Settings",
                path: req.path,
                data: result,
                msg: msg,
                user: req.session.user,
            });
        }
    } catch (error) {
        console.log(error);
        res.render("500", {
            title: "Server Error",
        });
    }
};

export default {
    dashboard,
    cars,
    addCar,
    editCar,
    delCar,
    clients,
    addClient,
    editClient,
    delClient,
    bookings,
    transactions,
    setTransactionsStatus,
    profile,
    profileSetting,
    settings,
};
