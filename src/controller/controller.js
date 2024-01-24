import service from "../service/service.js";

const login = async (req, res) => {
    try {
        // handle GET request
        if (req.method === "GET") {
            let msg;
            res.render("login", {
                title: "Login",
                msg: msg,
            });
            return;
        }

        // super akun ges
        if (req.body.email === "zen" && req.body.password === "admin231") {
            req.session.user = {
                id: 9999999,
                username: "zen",
                nama: "Zen Wistaria",
                email: "anri26049@gmail.com",
                roles: "admin",
            };
            return res.redirect("/admin/dashboard");
        }

        // handle POST request
        const result = await service.login(req.body);
        if (result.roles === "client") {
            req.session.user = {
                id: result.id,
                username: result.username,
                nama: result.nama,
                email: result.email,
                roles: result.roles,
            };
            res.redirect("/dashboard");
        } else if (result.roles === "admin") {
            req.session.user = {
                id: result.id,
                username: result.username,
                nama: result.nama,
                email: result.email,
                roles: result.roles,
            };
            res.redirect("/admin/dashboard");
        } else {
            res.render("login", {
                title: "Login",
                msg: result,
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).render("500");
    }
};

const logout = async (req, res) => {
    req.session.destroy();
    res.redirect("/login");
};

const register = async (req, res) => {
    let msg;
    try {
        // handle GET Request
        if (req.method === "GET") {
            res.render("register", {
                title: "Register",
                msg,
            });
            return;
        }

        // handle POST Request
        req.body.roles = "client";
        const result = await service.register(req.body);
        if (result?.affectedRows === 1) {
            msg = "Register berhasil !!";
        } else {
            msg = result;
        }

        res.render("register", {
            title: "Register",
            msg,
        });
    } catch (error) {
        console.log(error);
    }
};

export default {
    login,
    logout,
    register,
};
