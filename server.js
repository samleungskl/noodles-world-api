const express = require('express')
const cors = require('cors')
const app = express()

app.use(cors())

const resturantsRoute = require("./routes/resturants")
const ordersRoute = require("./routes/orders")
const hoursRoute = require("./routes/hours")
const itemsRoute = require("./routes/items")
const itemCategoriesRoute = require("./routes/item_categories")
const lineItemRoute = require("./routes/line_items")
const trackRoute = require("./routes/track")

app.use("/", resturantsRoute)
app.use("/", ordersRoute)
app.use("/", hoursRoute)
app.use("/", itemsRoute)
app.use("/", itemCategoriesRoute)
app.use("/", lineItemRoute)
app.use("/", trackRoute)

// Start server
app.listen(process.env.PORT || 3002, () => {
  console.log(`Server listening`)
})