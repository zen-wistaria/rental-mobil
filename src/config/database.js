import mysql from "serverless-mysql";
import dotenv from "dotenv";
dotenv.config();

const db = mysql({
    config: {
        host: process.env.MYSQL_HOST,
        port: process.env.MYSQL_PORT,
        database: process.env.MYSQL_DATABASE,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
    },
});

export default async function executeQuery({ query, values }) {
    try {
        const results = await db.query(query, values);
        db.end();
        return results;
    } catch (error) {
        db.end();
        console.log(error);
        return { error };
    }
}
