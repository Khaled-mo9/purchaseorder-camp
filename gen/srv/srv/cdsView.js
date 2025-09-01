// srv/viewAll-service.js
const cds = require('@sap/cds');

module.exports = cds.service.impl(function () {

  this.before('READ', 'viewAll', (req) => {
    
      const acceptLang = req.headers['accept-language']; // e.g., "en-US,en;q=0.9"
      const systemLang = acceptLang ? acceptLang.split(',')[0].split('-')[0] : 'EN';

      // Apply filter dynamically if not already present
      if (!req.query.where) {
        req.query.where({ language: systemLang.toUpperCase() });
      } else {
        req.query.where('language', '=', systemLang.toUpperCase());
      }
  });
});
