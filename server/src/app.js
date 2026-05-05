import express from "express";
import cors from "cors";
import routes from "./routes/index.js";

const app = express();

/// 🔥 Global Middlewares
app.use(cors());
app.use(express.json());

/// 📡 API Routes
app.use("/api", routes);

/// 🧪 Health Check Route
app.get("/", (req, res) => {
  res.status(200).json({
    success: true,
    message: "MOSM Backend Running 🚀",
  });
});

/// ❌ 404 Handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: "Route not found",
  });
});

export default app;