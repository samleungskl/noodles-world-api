// Importing express module
const express = require("express")
const bodyParser = require('body-parser')

// Creating express router
const router = express.Router()
const { pool } = require('../config')
router.use(bodyParser.json())
router.use(bodyParser.urlencoded({ extended: true }))

// Handling request using router
router.get("/hours", (req, res, next) => {
    pool
        .query('SELECT * FROM resturant_hours')
        .then(results => res.status(200).send(results.rows))
        .catch(e => console.error(e.stack))
})

router.get("/hours/:id", (req, res, next) => {
    const { id } = req.params;
    pool
        .query('SELECT * FROM resturant_hours WHERE hours_id=$1', [id])
        .then(results => res.status(200).send(results.rows))
        .catch(e => console.error(e.stack))
})


router.post("/hours", (req, res, next) => {
    const { day_of_week, start_time, end_time, resturant_id } = req.body
    pool
        .query('INSERT INTO resturant_hours (day_of_week, start_time, end_time, resturant_id) VALUES ($1, $2, $3, $4)',
            [day_of_week, start_time, end_time, resturant_id])
        .then(results => res.status(201).json({ status: 'success', message: 'Hours added.' }))
        .catch(e => console.error(e.stack))
})

router.put("/hours/:id", (req, res, next) => {
    const { id } = req.params;
    const { day_of_week, start_time, end_time, resturant_id } = req.body
    pool
        .query('UPDATE resturant_hours SET day_of_week=$1 , start_time=$2, end_time=$3, resturant_id=$4 WHERE hours_id=$5',
            [day_of_week, start_time, end_time, resturant_id, id])
        .then(results => res.status(201).json({ status: 'success', message: 'Hours updated.' }))
        .catch(e => console.error(e.stack))
})

router.delete("/hours/:id", (req, res, next) => {
    const { id } = req.params;
    pool
        .query('DELETE FROM hours WHERE hours_id=$1',
            [id])
        .then(results => res.status(201).json({ status: 'success', message: 'Hours deleted.' }))
        .catch(e => console.error(e.stack))
})


// Exporting router
module.exports = router