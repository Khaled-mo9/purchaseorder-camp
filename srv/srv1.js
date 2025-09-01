const axios = require('axios');
const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

    const { Posts } = this.entities;
    
    this.on('READ', async (req) => {
        try {
            const response = await axios.get('https://jsonplaceholder.typicode.com/posts');
            const res = response.data.map(post => ({
                userId: post.userId,
                title : post.title,
                body: post.body
            }));
            return res;
        } catch (error) {
            req.error(400, 'Faild to fetch data from API')
        }
    })
})