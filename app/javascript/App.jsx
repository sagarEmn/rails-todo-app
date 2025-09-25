// app/javascript/App.jsx
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import TodoShow from './components/TodoShow';
// Import other components as needed
// import TodoIndex from './components/TodoIndex';
// import TodoEdit from './components/TodoEdit';
// import TodoNew from './components/TodoNew';

const App = () => {
  return (
    <Router>
      <div className="app-container">
        <Routes>
          {/* Define your routes here */}
          <Route path="/todos/:id" element={<TodoShow />} />
          {/* Uncomment these routes as you implement the components */}
          {/* <Route path="/todos" element={<TodoIndex />} /> */}
          {/* <Route path="/todos/new" element={<TodoNew />} /> */}
          {/* <Route path="/todos/:id/edit" element={<TodoEdit />} /> */}
        </Routes>
      </div>
    </Router>
  );
};

export default App;