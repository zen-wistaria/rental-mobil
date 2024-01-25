import clientService from "../service/client-service.js";

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
        res.redirect("/cars");
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
        res.redirect("/booking");
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
        res.redirect("/transactions");
    } catch (error) {
        console.log(error);
        res.status(500).render("500", {
            title: "Server Error",
        });
    }
};

const profile = async (req, res) => {
    res.render("client/profile", {
        title: "Profile",
        path: req.path,
    });
};

export default {
    index,
    getCars,
    getBooking,
    delBooking,
    transactions,
    setTransactionsStatus,
    profile,
};
