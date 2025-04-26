// This is a proxy file to load the actual server from the api-server directory
// This exists to make Render.com's deployment process simpler

console.log('Starting Food Analyzer API Server...');
console.log('Delegating to api-server/server.js');

// Load the actual server implementation
require('./api-server/server.js'); 