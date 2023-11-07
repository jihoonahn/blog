/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./Sources/*.{swift}"
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
};

