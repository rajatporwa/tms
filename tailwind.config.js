module.exports = {
  content: [
    './app/views/**/*.{html,erb}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/components/**/*.{html,erb,js}',
  ],
  safelist: [
    {
      pattern: /(bg|text)-(red|green|blue|purple|gray)-(100|200|300|400|500|600|700|800|900)/
    }
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}