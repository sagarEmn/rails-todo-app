// app/javascript/application.js
import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';

// Import styles
import './components/TodoShow.css';

// Wait for the DOM to be loaded
document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('react-app');
  if (container) {
    const root = createRoot(container);
    root.render(
      <React.StrictMode>
        <App />
      </React.StrictMode>
    );
  }
});