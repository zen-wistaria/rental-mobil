import express from "express";
import controller from "../controller/controller.js";

const router = new express.Router();
router.route("/login").get(controller.login).post(controller.login);
router.get("/logout", controller.logout);
router.route("/register").get(controller.register).post(controller.register);

export { router };
