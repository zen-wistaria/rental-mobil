import express from "express";
import { router } from "../router/router.js";
import { adminRouter } from "../router/admin-router.js";
import { clientRouter } from "../router/client-router.js";
import session from "express-session";
import methodOverride from "method-override";

export const app = new express();

app.set("views", "src/views");
app.set("view engine", "ejs");
app.use("/public", express.static("public"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(
    session({
        secret: "sangatrahasia",
        resave: false,
        saveUninitialized: true,
        cookie: {
            maxAge: 3600000,
        },
    })
);
app.use(methodOverride("_method"));

app.use(router);
app.use("/client", clientRouter);
app.use("/admin", adminRouter);

app.get("/", (req, res) => {
    res.redirect("/login");
});
app.use("/", (req, res) => {
    res.status(400).render("404", {
        title: "Page Not Found",
        pageTitle: "Page Not Found",
    });
});
