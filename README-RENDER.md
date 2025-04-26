# Food Analyzer API Deployment Guide

This is an API service for analyzing food images using OpenAI's Vision API.

## Render.com Deployment

1. **Environment Variables**
   Set the following environment variables in Render.com:
   - `OPENAI_API_KEY`: Your OpenAI API key
   - `RATE_LIMIT`: Request limit per minute (default: 30)
   - `ALLOWED_ORIGINS`: Comma-separated list of allowed origins for CORS

2. **Build Command**
   ```
   npm install
   ```

3. **Start Command**
   ```
   npm start
   ```

## API Endpoints

- **GET /** - Health check endpoint
- **POST /api/analyze-food** - Analyze food images
  - Request body: `{ "image": "base64-encoded-image-or-datauri" }`
  - Response: `{ "success": true, "data": { ... nutritional data ... } }`

## Local Development

```
npm install
npm start
```

This will start the API server on port 3000 (or the port specified in the PORT environment variable). 