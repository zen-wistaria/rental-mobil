import clientService from "../service/client-service.js";
import bcrypt from "bcrypt";

const index = async (req, res) => {
    res.render("client/index", {
        title: "Dashboard",
        title_page: "Dashboard",
        path: req.path,
        msg: "",
        user: req.session.user,
    });
};
const getCars = async (req, res) => {
    let msg;
    try {
        // handle GET
        if (req.method === "GET") {
            const page = parseInt(req.query.page) || 1;
            const result = await clientService.getCars(page);
            res.render("client/cars", {
                title: "Cars",
                title_page: "Mobil",
                path: req.path,
                data: result,
                msg: msg,
                user: req.session.user,
            });
            return;
        }

        // handle POST
        const result = await clientService.bookingCars(req.body);
        res.redirect("/client/cars");
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};

const getBooking = async (req, res) => {
    let msg;
    try {
        const id_user = req.session.user.id;
        const page = req.query.page || 1;
        const result = await clientService.getBooking(id_user, page);
        res.render("client/bookings", {
            title: "Booking",
            title_page: "Booking",
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

const delBooking = async (req, res) => {
    try {
        const bookingId = req.query.id;
        const mobilId = req.body.id_mobil;
        await clientService.delBooking(bookingId, mobilId);
        res.redirect("/client/booking");
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
        const id_user = req.session.user.id;
        const result = await clientService.getTransactions(id_user, page);
        res.render("client/transactions", {
            title: "Transactions",
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
        const result = await clientService.setTransactionsStatus(
            transactionsId,
            status
        );
        res.redirect("/client/transactions");
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
            const result = await clientService.getCurrentUser(
                req.session.user.id
            );
            res.render("client/profile", {
                title: "Profile",
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
        const result = await clientService.updateProfileUser(
            req.session.user.id,
            req.body
        );
        res.redirect("/client/profile");
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
            const result = await clientService.getCurrentUser(
                req.session.user.id
            );
            res.render("client/profile-setting", {
                title: "Profil Setting",
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
            // check current password
            const user = await clientService.getCurrentUser(
                req.session.user.id
            );
            const check = await bcrypt.compare(
                req.body.password_current,
                user[0].password
            );
            if (!check) {
                msg = "Password lama tidak sesuai !!";
                return res.render("client/profile-setting", {
                    title: "Profil Setting",
                    title_page: "Profil Setting",
                    path: req.path,
                    data: user,
                    msg: msg,
                    user: req.session.user,
                });
            }

            // update password
            const result = await clientService.updatePassword(
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
            const update = await clientService.updateProfileUser(
                req.session.user.id,
                req.body
            );

            if (update.affectedRows === 1) {
                msg = "Data berhasil di update !!";
            } else {
                msg = "Data gagal di update !!";
            }
        }

        const result = await clientService.getCurrentUser(req.session.user.id);
        res.render("client/profile-setting", {
            title: "Profil Setting",
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

const photoFiles = async (req, res) => {
    const result = await clientServer.getFiles();
    res.send(result);
};

export default {
    index,
    getCars,
    getBooking,
    delBooking,
    transactions,
    setTransactionsStatus,
    profile,
    profileSetting,
    photoFiles,
};
