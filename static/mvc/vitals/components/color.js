class ColorGenerator {
    generateRandomContrastingColor() {
        const hue = Math.floor(Math.random() * 360);
        const saturation = '70%';
        const lightness = Math.floor(Math.random() * 25) + 70 + '%'; // Generates lightness values between 70% and 95%
        return `hsl(${hue}, ${saturation}, ${lightness})`;
      }
      
      // Get contrasting color based on background color
      getContrastingColor(color) {
        let luminance;
        if (color.startsWith('rgb')) {
          // RGB color
          const rgbValues = color.match(/(\d+)/g).map(Number);
          luminance = 0.2126 * rgbValues[0] + 0.7152 * rgbValues[1] + 0.0722 * rgbValues[2];
        } else {
          // HSL color
          const hslValues = color.match(/(\d+)/g).map(Number);
          const s = hslValues[1] / 100;
          const l = hslValues[2] / 100;
          const r = l + s * Math.min(l, 1 - l);
          const g = l + s * Math.min(l, 1 - l);
          const b = l - s * Math.min(l, 1 - l) / 2;
          luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b;
        }
        return luminance > 0.5 ? 'black' : 'white';
      }
}


export default ColorGenerator