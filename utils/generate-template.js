const fs = require('fs');
const path = require('path');

const domain = process.env.DOMAIN;
const template = process.env.TEMPLATE;

try {
  const templateData = fs.readFileSync(path.resolve(__dirname, `../templates/${template}`), 'utf8');
  const result = templateData.replaceAll('{{DOMAIN}}', domain);

  console.log(result);
} catch (err) {
  console.error(err);
}
