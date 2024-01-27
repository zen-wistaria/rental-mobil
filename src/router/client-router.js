import express from "express";
import clientController from "../controller/client-controller.js";
import { authClient } from "../middleware/auth.js";

const clientRouter = new express.Router();
clientRouter.use(authClient);
clientRouter.get("/dashboard", clientController.index);
clientRouter
    .route("/cars")
    .get(clientController.getCars)
    .post(clientController.getCars);
clientRouter
    .route("/booking")
    .get(clientController.getBooking)
    .delete(clientController.delBooking);
clientRouter
    .route("/transactions")
    .get(clientController.transactions)
    .patch(clientController.setTransactionsStatus);
clientRouter.route("/profile").get(clientController.profile);
// clientRouter.get("/admin/dashboard/profile/:photos", clientController.getPhotos);
clientRouter
    .route("/profile/setting")
    .get(clientController.profileSetting)
    .patch(clientController.profileSetting);
clientRouter.get("/profile/:foto", clientController.profile);

export { clientRouter };
