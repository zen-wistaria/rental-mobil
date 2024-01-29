import express from "express";
import adminController from "../controller/admin-controller.js";
import { authAdmin } from "../middleware/auth.js";

const adminRouter = new express.Router();
adminRouter.use(authAdmin);
adminRouter.get("/dashboard", adminController.dashboard);
adminRouter
    .route("/cars")
    .get(adminController.cars)
    .post(adminController.addCar)
    .put(adminController.editCar)
    .delete(adminController.delCar);
adminRouter.get("/cars/add", adminController.addCar);
adminRouter.get("/cars/edit", adminController.editCar);
adminRouter
    .route("/clients")
    .get(adminController.clients)
    .post(adminController.addClient)
    .patch(adminController.editClient)
    .delete(adminController.delClient);
adminRouter.get("/clients/add", adminController.addClient);
adminRouter.get("/clients/edit", adminController.editClient);
adminRouter
    .route("/booking")
    .get(adminController.bookings)
    .patch(adminController.bookings);
adminRouter
    .route("/transactions")
    .get(adminController.transactions)
    .patch(adminController.setTransactionsStatus);
adminRouter.route("/profile").get(adminController.profile);
adminRouter
    .route("/profile/setting")
    .get(adminController.profileSetting)
    .patch(adminController.profileSetting);
adminRouter
    .route("/settings")
    .get(adminController.settings)
    .patch(adminController.settings);
adminRouter.get("/settings/:kode", adminController.settings);

export { adminRouter };
