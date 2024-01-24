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
        res.render("client/booking", {
            title: "Booking",
            title_page: "Booking",
            path: req.path,
            data: result,
            msg: msg,
            user: req.session.user,
        });
    } catch (error) {}
};

const delBooking = async (req, res) => {
    try {
        const bookingId = req.query.id;
        await clientService.delBooking(bookingId);
        res.redirect("/booking");
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
    profile,
};
