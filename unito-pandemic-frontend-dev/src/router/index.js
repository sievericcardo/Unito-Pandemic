import Vue from "vue";
import VueRouter from "vue-router";
import HomePage from "../components/pages/HomePage";
import DashBoard from "../components/pages/DashBoard";

Vue.use(VueRouter);

const routes = [
    {
        path: "/",
        name: "Home",
        component: HomePage,
    },
    {
        path: "/dashboard",
        name: "DashBoard",
        component: DashBoard,
    },
];

const router = new VueRouter({
    routes,
});

export default router;
