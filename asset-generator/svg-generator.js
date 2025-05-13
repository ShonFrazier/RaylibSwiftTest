#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// Team and color data
const teamsData = {
  "teams": [
    {
      "team": "Real Broccoli",
      "colors": {
        "primary": "Forest Green",
        "secondary": "Cream"
      }
    },
    {
      "team": "FC Offside Trap",
      "colors": {
        "primary": "Neon Yellow",
        "secondary": "Black"
      }
    },
    {
      "team": "Nutmeg County FC",
      "colors": {
        "primary": "Burnt Orange",
        "secondary": "Plum"
      }
    },
    {
      "team": "Wheezington Rovers",
      "colors": {
        "primary": "Dusty Gray",
        "secondary": "Maroon"
      }
    },
    {
      "team": "Banana Hill United",
      "colors": {
        "primary": "Bright Yellow",
        "secondary": "Grass Stain Green"
      }
    },
    {
      "team": "Sporting Badger",
      "colors": {
        "primary": "Black",
        "secondary": "Blood Red"
      }
    }
  ],
  "colors": [
    { "name": "Forest Green", "r": 34, "g": 139, "b": 34, "a": 255 },
    { "name": "Cream", "r": 255, "g": 253, "b": 208, "a": 255 },
    { "name": "Neon Yellow", "r": 207, "g": 255, "b": 0, "a": 255 },
    { "name": "Black", "r": 0, "g": 0, "b": 0, "a": 255 },
    { "name": "Burnt Orange", "r": 204, "g": 85, "b": 0, "a": 255 },
    { "name": "Plum", "r": 142, "g": 69, "b": 133, "a": 255 },
    { "name": "Dusty Gray", "r": 169, "g": 169, "b": 169, "a": 255 },
    { "name": "Maroon", "r": 128, "g": 0, "b": 0, "a": 255 },
    { "name": "Bright Yellow", "r": 255, "g": 255, "b": 0, "a": 255 },
    { "name": "Grass Stain Green", "r": 86, "g": 130, "b": 3, "a": 255 },
    { "name": "Blood Red", "r": 138, "g": 3, "b": 3, "a": 255 },
    { "name": "White", "r": 255, "g": 255, "b": 255, "a": 255 }
  ]
};

// Helper function to get RGB value for a color name
function getRGBColor(colorName) {
  const color = teamsData.colors.find(c => c.name === colorName);
  if (!color) {
    console.error(`Color not found: ${colorName}`);
    return "rgb(0, 0, 0)";
  }
  return `rgb(${color.r}, ${color.g}, ${color.b})`;
}

// Create the output directory if it doesn't exist
const outputDir = path.join(process.cwd(), 'output');
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

// Generate SVG functions for each design
function generateRingDesign(primary, secondary) {
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="200" height="200">
    <circle cx="50" cy="50" r="45" fill="${primary}" />
    <circle cx="50" cy="50" r="30" fill="white" />
    <circle cx="50" cy="50" r="25" fill="${secondary}" />
  </svg>`;
}

function generateStripeDesign(primary, secondary) {
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="200" height="200">
    <circle cx="50" cy="50" r="45" fill="${primary}" />
    <rect x="5" y="40" width="90" height="20" fill="${secondary}" />
  </svg>`;
}

function generateDiamondDesign(primary, secondary) {
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="200" height="200">
    <circle cx="50" cy="50" r="45" fill="${secondary}" />
    <path d="M50,5 L95,50 L50,95 L5,50 Z" fill="${primary}" />
  </svg>`;
}

// Generate SVGs for each team and each design
console.log('Generating SVG files...');

teamsData.teams.forEach(team => {
  const teamName = team.team.replace(/\s+/g, '_').toLowerCase();
  const primaryColor = getRGBColor(team.colors.primary);
  const secondaryColor = getRGBColor(team.colors.secondary);
  
  // Generate ring design
  const ringDesign = generateRingDesign(primaryColor, secondaryColor);
  fs.writeFileSync(path.join(outputDir, `${teamName}_ring.svg`), ringDesign);
  
  // Generate stripe design
  const stripeDesign = generateStripeDesign(primaryColor, secondaryColor);
  fs.writeFileSync(path.join(outputDir, `${teamName}_stripe.svg`), stripeDesign);
  
  // Generate diamond design
  const diamondDesign = generateDiamondDesign(primaryColor, secondaryColor);
  fs.writeFileSync(path.join(outputDir, `${teamName}_diamond.svg`), diamondDesign);
  
  console.log(`Generated SVGs for ${team.team}`);
});

console.log(`All SVG files have been saved to the '${outputDir}' directory`);