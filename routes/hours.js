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
    pool.query('SELECT * FROM resturant_hours', (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).send(results.rows)
    })
})

router.get("/hours/:id", (req, res, next) => {
    const { id } = req.params;
    pool.query('SELECT * FROM resturant_hours WHERE hours_id=$1',
    [id],
    (error, results) => {
        if (error) {
            throw error
        }
        console.log(results)
        res.status(200).send(results.rows)
    })
})


router.post("/hours", (req, res, next) => {
    const { day_of_week, start_time, end_time, resturant_id } = req.body

    pool.query(
        'INSERT INTO resturant_hours (day_of_week, start_time, end_time, resturant_id) VALUES ($1, $2, $3, $4)',
        [day_of_week, start_time, end_time, resturant_id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'Hours added.' })
        }
    )
})

router.put("/hours/:id", (req, res, next) => {
    const { id } = req.params;
    const { day_of_week, start_time, end_time, resturant_id } = req.body

    pool.query(
        'UPDATE resturant_hours SET day_of_week=$1 , start_time=$2, end_time=$3, resturant_id=$4 WHERE hours_id=$5',
        [day_of_week, start_time, end_time, resturant_id, id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'Hours updated.' })
        }
    )
})

router.delete("/hours/:id", (req, res, next) => {
    const { id } = req.params;

    pool.query(
        'DELETE FROM hours WHERE hours_id=$1',
        [id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(204).json({ status: 'success', message: 'Hours deleted.' })
        }
    )
})


// Exporting router
module.exports = router