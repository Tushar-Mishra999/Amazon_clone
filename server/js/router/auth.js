const {
    json
} = require('express');
const express = require('express');
const authRouter = express.Router();
const bcrypt = require('bcryptjs');
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
const request = require('request');

authRouter.post("/api/signup", async (req, res) => {
    try {
        const {
            name,
            email,
            password,
            type
        } = req.body;
        const existingUser = await User.findOne({
            email
        });
        if (existingUser) {
            return res.status(400).json({
                msg: "User with same email already exists!"
            });
        }
        const hashedPassword = await bcrypt.hash(password, 8);
        let user = new User({
            email,
            password: hashedPassword,
            name,
            type,
        });

        user = await user.save();
        let body={email,name}
        if (type=="user"){
            request({
                url: 'https://ecommerce-app-dbms-project-hazr6.ondigitalocean.app/register',
                method: "POST",
                json: true,
                body: body
                }, function (error, response, body) {
                    if (!error && response.statusCode == 200) {
                        console.log(body);
                    } else {
                        throw error;
                    }
                }
            );
        } else if (type=="seller"){
            request({
                url: 'https://octopus-app-95tr7.ondigitalocean.app/register',
                method: "POST",
                json: true,
                body: body
                }, function (error, response, body) {
                    if (!error && response.statusCode == 200) {
                        console.log(body);
                    } else {
                        throw error;
                    }
                }
            );
        }
        res.json(user);
    } catch (e) {
        return res.status(500).json({
            error: e.message
        });
    }

})

authRouter.post("/api/signin", async (req, res) => {
    try {
        const {
            email,
            password
        } = req.body;
        const user = await User.findOne({
            email
        });
        if (!user) {
            return res.status(400).json({
                msg: "Email id doesn't exists"
            });
        }
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({
                msg: "Invalid password"
            });
        }

        const token = jwt.sign({
            id: user._id
        }, "0898a671f37849d79ed8126dd469dcd1");
        res.json({
            token,
            ...user._doc
        });

    } catch (e) {
        res.status(500).json({
            error: e.message
        });
    }
})

authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "0898a671f37849d79ed8126dd469dcd1");
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if (!user) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({
            error: e.message
        });
    }
});


authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({
        ...user._doc,
        token: req.token
    });
});

module.exports = authRouter;