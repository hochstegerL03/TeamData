// eslint-disable-next-line no-unused-vars
const errorHandler = (err, req, res, next) => {
  console.log(`ERROR ====> ${err.message}`);
  return res.status(500).send('The server has encountered an error.');
};

const notFoundHandler = (req, res, next) => {
  console.log(`NOT FOUND ====> ${req.originalUrl}`);
  res.status(404).send('Ressource not found!');
  next();
};

export { errorHandler, notFoundHandler };
