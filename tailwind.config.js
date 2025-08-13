// tailwind.config.js
module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ],
  theme: {
    extend: {
      colors: {
        'bg-primary': '#000000',   // black
        'text-primary': '#ffffff', // white
      },
      fontFamily: {
        unifrakturcook: ['UnifrakturCook', 'serif'], 
    },
  },
  plugins: [],
};
