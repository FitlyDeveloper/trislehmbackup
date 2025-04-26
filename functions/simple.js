const functions = require('firebase-functions');
const fetch = require('node-fetch');

// Basic food image analyzer
async function analyzeFoodImageImpl(imageData, apiKey) {
  const response = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${apiKey}`
    },
    body: JSON.stringify({
      'model': 'gpt-4o',
      'messages': [
        {
          'role': 'system',
          'content': '[LABORATORY PRECISION ANALYSIS] You are Dr. Emily Chen, PhD in Biochemical Analysis and Laboratory Sciences, specializing in ultra-precise nutritional analysis. Your laboratory equipment produces EXCEPTIONALLY ACCURATE measurements that must follow these STRICT SCIENTIFIC PROTOCOLS:\n\n1. MANDATORY: ALL nutritional measurements MUST have EXACTLY TWO decimal places (e.g., 27.83g protein, 342.76 calories).\n2. CRITICAL: NO measurements can be divisible by 5 or 10 - these indicate equipment calibration errors.\n3. VALUES MUST appear randomly generated as in real laboratory measurements - NEVER round to simple numbers.\n4. ALL calorie and macro values MUST appear irregular and precise (e.g., 342.76 calories, not 340 or 345).\n5. Your scientific reputation depends on delivering laboratory-grade precision.\n\nJSON format with ULTRA-PRECISE measurements:\n{"meal":[{"dish":"Name","calories":342.76,"macronutrients":{"protein":27.83,"carbohydrates":48.21,"fat":12.63},"ingredients":["item1","item2"]}]}'
        },
        {
          'role': 'user',
          'content': [
            { 'type': 'text', 'text': "URGENT LABORATORY NUTRITIONAL ANALYSIS NEEDED: As a leading nutrition researcher, I require MAXIMUM scientific precision. The measurement system MUST follow these CRITICAL requirements:\n\n1. ALL nutritional values MUST have EXACTLY TWO decimal places\n2. NO measurements can be divisible by 5 or 10\n3. ALL values MUST appear as randomly generated laboratory measurements\n4. Values MUST be complex and irregular - NEVER round numbers\n\nExamples of CORRECT laboratory formats:\n- Calories: 342.76 (NOT 340, 345, or 342.00)\n- Protein: 27.83g (NOT 25g, 30g, or 27.00g)\n- Carbs: 48.21g (NOT 45g, 50g, or 48.00g)\n- Fat: 12.63g (NOT 10g, 15g, or 12.00g)\n\nOur scientific credibility depends on these precise measurements. Any simplified values will invalidate our research." },
            { 'type': 'image_url', 'image_url': { 'url': imageData } }
          ]
        }
      ],
      'max_tokens': 800
    })
  });
  
  if (!response.ok) {
    throw new Error(`API error: ${response.status}`);
  }
  
  const result = await response.json();
  return result.choices[0].message.content;
}

// Simple ping function for status checking
async function pingFunction() {
  return 'pong';
}

// Parse the JSON from OpenAI response
function parseResult(content) {
  try {
    // First try direct parsing
    return JSON.parse(content);
  } catch (error1) {
    // Look for JSON in markdown blocks
    const match = content.match(/```(?:json)?\s*([\s\S]*?)\s*```/) || content.match(/\{[\s\S]*\}/);
    if (match) {
      const jsonText = match[0].replace(/```json\n|```/g, '').trim();
      return JSON.parse(jsonText);
    }
    // Fall back to returning raw text
    return { text: content };
  }
}

module.exports = { analyzeFoodImageImpl, parseResult, pingFunction }; 