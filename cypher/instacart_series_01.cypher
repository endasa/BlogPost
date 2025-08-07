LOAD CSV WITH HEADERS FROM 'file:///aisles.csv' AS row
CREATE (n:Aisle)
   SET n.aisleId = toInteger(row.aisle_id)
     , n.aisle = row.aisle
;

LOAD CSV WITH HEADERS FROM 'file:///departments.csv' AS row
CREATE (n:Department)
   SET n.departmentId = toInteger(row.department_id)
     , n.department = row.department
;

LOAD CSV WITH HEADERS FROM 'file:///order_products.csv' AS row
CALL (row) {
    CREATE (n:OrderProduct)
       SET n.orderId = toInteger(row.order_id)
         , n.productId = toInteger(row.product_id)
         , n.addToCartOrder = toInteger(row.add_to_cart_order)
         , n.reordered = toInteger(row.reordered)
} IN TRANSACTIONS
;

LOAD CSV WITH HEADERS FROM 'file:///orders.csv' AS row
CALL (row) {
    CREATE (n:Order)
       SET n.orderId = toInteger(row.order_id)
         , n.userId = toInteger(row.user_id)
         , n.evalSet = row.eval_set
         , n.orderNumber = toInteger(row.order_number)
         , n.orderDow = toInteger(row.order_dow)
         , n.orderHourOfDay = row.order_hour_of_day
         , n.daysSincePriorOrder = toFloat(row.days_since_prior_order)
} IN TRANSACTIONS
;

LOAD CSV WITH HEADERS FROM 'file:///products.csv' AS row
CREATE (n:Product)
   SET n.productId = toInteger(row.product_id)
     , n.productName = row.product_name
     , n.aisleId = toInteger(row.aisle_id)
     , n.departmentId = toInteger(row.department_id)
;

MATCH (p:Product)
MATCH (a:Aisle)
WHERE p.aisleId = a.aisleId
CREATE (p)-[:LOCATED]->(a)
;

MATCH (d:Department)
MATCH (p:Product)
WHERE d.departmentId = p.departmentId
CREATE (d)-[:PART_OF]->(p)
;

MATCH (op:OrderProduct)
MATCH (o:Order)
WHERE op.orderId = o.orderId
CALL (*) {
    CREATE (op)-[:IS_ORDER]->(o)
} IN TRANSACTIONS
;

MATCH (op:OrderProduct)
MATCH (p:Product)
WHERE op.productId = p.productId
CALL (*) {
    CREATE (op)-[:IS_PRODUCT]->(p)
} IN TRANSACTIONS
;

