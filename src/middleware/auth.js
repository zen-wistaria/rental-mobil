const authClient = async (req, res, next) => {
    try {
        if (!req.session.user) {
            return res.redirect("/login");
        }
    } catch (error) {
        console.log(error);
    }
    next();
};

const authAdmin = async (req, res, next) => {
    try {
        if (!req.session.user) {
            return res.redirect("/login");
        }
        if (req.session.user.roles !== "admin") {
            return res.redirect("/");
        }
    } catch (error) {
        console.log(error);
    }
    next();
};

export { authClient, authAdmin };
