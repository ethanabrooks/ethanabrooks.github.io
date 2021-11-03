const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  purge: [
    './src/**/*.html',
    './src/**/*.res',
    './src/**/*.js',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    maxHeight: {
      'screen': '90vh',
    },
    extend: {},
  },
  variants: {
    extend: {
      opacity: ['disabled']
    }
  },
  plugins: [],
}

