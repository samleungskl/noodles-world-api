// Importing express module
const express = require("express")
const bodyParser = require('body-parser')

// Creating express router
const router = express.Router()
const { pool } = require('../config')
router.use(bodyParser.json())
router.use(bodyParser.urlencoded({ extended: true }))

// Handling request using router
router.get("/item_categories", (req, res, next) => {
    pool.query('SELECT * FROM item_categories', (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).send(results.rows)
    })
})

router.get("/item_categories/:id", (req, res, next) => {
    const { id } = req.params;
    pool.query('SELECT * FROM item_categories WHERE category_id=$1',
    [id],
    (error, results) => {
        if (error) {
            throw error
        }
        console.log(results)
        res.status(200).send(results.rows)
    })
})


router.post("/item_categories", (req, res, next) => {
    const { category_name } = req.body

    pool.query(
        'INSERT INTO item_categories (category_name) VALUES ($1)',
        [category_name],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'Category added.' })
        }
    )
})

router.put("/item_categories/:id", (req, res, next) => {
    const { id } = req.params;
    const { category_name } = req.body

    pool.query(
        'UPDATE item_categories SET category_name=$1 WHERE category_id=$2',
        [category_name, id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'Category updated.' })
        }
    )
})

router.delete("/item_categories/:id", (req, res, next) => {
    const { id } = req.params;

    pool.query(
        'DELETE FROM item_categories WHERE category_id=$1',
        [id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(204).json({ status: 'success', message: 'Category deleted.' })
        }
    )
})


// Exporting router
module.exports = router