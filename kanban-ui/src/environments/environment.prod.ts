export const environment = {
  production: true,
  //kanbanAppUrl: process.env.API_URL
  //kanbanAppUrl: '/api'
  //kanbanAppUrl: 'http://localhost:8080/api'
  kanbanAppUrl: $ENV.PROD_BACKEND_URL
};
