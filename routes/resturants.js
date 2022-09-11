// Importing express module
const express = require("express")
const bodyParser = require('body-parser')

// Creating express router
const router = express.Router()
const { pool } = require('../config')

router.use(bodyParser.json())
router.use(bodyParser.urlencoded({ extended: true }))

// Handling request using router
router.get("/resturants", (req, res, next) => {
    pool
        .query('SELECT * FROM resturants')
        .then(results => res.status(200).send(results.rows))
        .catch(e => console.error(e.stack))
})

router.get("/resturants/:id", (req, res, next) => {
    const { id } = req.params;
    pool
        .query('SELECT * FROM resturants WHERE resturant_id=$1',
            [id])
        .then(results => res.status(200).send(results.rows))
        .catch(e => console.error(e.stack))
})

router.post("/resturants", (req, res, next) => {
    const { resturant_name, resturant_phone_number, resturant_street_address, resturant_city_address, resturant_postal_code_address } = req.body
    pool
        .query('INSERT INTO resturants (resturant_name, resturant_phone_number, resturant_street_address, resturant_city_address,resturant_postal_code_address) VALUES ($1, $2, $3, $4, $5)',
            [resturant_name, resturant_phone_number, resturant_street_address, resturant_city_address, resturant_postal_code_address])
        .then(results => res.status(201).json({ status: 'success', message: 'Resturant added.' }))
        .catch(e => console.error(e.stack))
})

router.put("/resturants/:id", (req, res, next) => {
    const { id } = req.params;
    const { resturant_name, resturant_phone_number, resturant_street_address, resturant_city_address, resturant_postal_code_address } = req.body

    pool
        .query('UPDATE resturants SET resturant_name=$1 , resturant_phone_number=$2, resturant_street_address=$3, resturant_city_address=$4, resturant_postal_code_address=$5 WHERE resturant_id=$6',
            [resturant_name, resturant_phone_number, resturant_street_address, resturant_city_address, resturant_postal_code_address, id])
        .then(results => res.status(201).json({ status: 'success', message: 'Resturant updated.' }))
        .catch(e => console.error(e.stack))
})


router.delete("/resturants/:id", (req, res, next) => {
    const { id } = req.params;

    pool
        .query('DELETE FROM resturants WHERE resturant_id=$1',
            [id])
        .then(results => res.status(201).json({ status: 'success', message: 'Resturant deleted.' }))
        .catch(e => console.error(e.stack))
})

// Exporting router
module.exports = router