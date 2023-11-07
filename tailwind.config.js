/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./Sources/*/*.swift"
  ],
  theme: {
    fontFamily: {
      'sans': ['Open Sans', 'sans-serif']
    },
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
};
