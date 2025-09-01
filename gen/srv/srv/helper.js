const cds = require("@sap/cds");
const { message } = require("@sap/cds/lib/log/cds-error");

module.exports = cds.service.impl(async function () {
    
    const { purchaseorderitems } = this.entities;

    // action => increment the quan
    this.on('increment', async (req) => {

        const { purchase_order_number } = req.data;

        if (!purchase_order_number) {
            return req.error(400, `purchase_order_number is required`);
        }

        const tx = cds.transaction(req);

        try {
            // Read the data
            const items = await tx.read(purchaseorderitems)
                .where({ purchase_order_number });

            if (!items.length) {
                return req.reject(404, `No items found for purchase_order_number: ${purchase_order_number}`);
            }

            const quan = items[0].quantity;

            // Update
            const result = await tx.update(purchaseorderitems)
                .set({ quantity: quan + 500 })
                .where({ purchase_order_number });

            if (!result) {
                return req.reject(500, `Failed to update quantity for purchase_order_number: ${purchase_order_number}`);
            }

            // Return updated record
            return {
                message: "Incremented",
                updatedQuantity: quan + 500
            };

        } catch (error) {
            console.error(error);
            return req.reject(500, 'Error in increment action');
        }
    });

    // function => totals of item
    this.on('totals', async (req) => {
        const { purchase_order_number } = req.data;

        if (!purchase_order_number) {
            return req.error(400, `PO number is required`)
        }

        const results = await SELECT.from(purchaseorderitems)
                                    .where({purchase_order_number})
                                    .columns(`count(*) as count`);
        
        const count = results[0].count || 0;

        if (count == 0) {
            return req.error(404, `No items for this po number : ${purchase_order_number}`)
        }

        return {
            message: 'Number of items',
            items : count
        }
    })
});
