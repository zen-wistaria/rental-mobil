const authClient = async (req, res, next) => {
    try {
        if (!req.session.user) {
            return res.redirect("/login");
        }
        if (req.session.user.roles === "client") {
            next();
        } else {
            res.redirect("/login");
        }
    } catch (error) {
        console.log(error);
    }
};

const authAdmin = async (req, res, next) => {
    try {
        if (!req.session.user) {
            return res.redirect("/login");
        }
        if (req.session.user.roles === "admin") {
            next();
        } else {
            res.redirect("/login");
        }
    } catch (error) {
        console.log(error);
    }
};

export { authClient, authAdmin };
