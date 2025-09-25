import React, { useState, useEffect } from 'react';
import { Link, useParams, useNavigate } from 'react-router-dom';
import axios from 'axios';
import moment from 'moment';

const TodoShow = () => {
  const [todo, setTodo] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const { id } = useParams();
  const navigate = useNavigate();

  useEffect(() => {
    const fetchTodo = async () => {
      try {
        // Assuming you have an API endpoint like /api/todos/:id
        const response = await axios.get(`/api/todos/${id}`);
        setTodo(response.data);
        setLoading(false);
      } catch (err) {
        setError('Failed to load todo. Please try again later.');
        setLoading(false);
        console.error('Error fetching todo:', err);
      }
    };

    fetchTodo();
  }, [id]);

  const handleDelete = async () => {
    if (!window.confirm('Are you sure you want to delete this todo?')) {
      return;
    }

    try {
      await axios.delete(`/api/todos/${id}`, {
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        }
      });
      navigate('/todos');
    } catch (err) {
      setError('Failed to delete todo. Please try again later.');
      console.error('Error deleting todo:', err);
    }
  };

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  if (error) {
    return <div className="error">{error}</div>;
  }

  if (!todo) {
    return <div className="not-found">Todo not found</div>;
  }

  const formatDate = (dateString) => {
    return moment(dateString).format('MMMM D, YYYY [at] h:mm A');
  };

  return (
    <div className="todo-detail">
      <div className="todo-header">
        <h1>{todo.title}</h1>
        <span className={`status-badge ${todo.completed ? 'completed' : 'pending'}`}>
          {todo.completed ? '✓ Completed' : '○ Pending'}
        </span>
      </div>
      
      <div className="todo-body">
        {todo.description && (
          <div className="description">
            <h3>Description:</h3>
            <p>{todo.description}</p>
          </div>
        )}
        
        <div className="todo-meta">
          <p><strong>Created:</strong> {formatDate(todo.created_at)}</p>
          <p><strong>Last Updated:</strong> {formatDate(todo.updated_at)}</p>
        </div>
      </div>
      
      <div className="todo-actions">
        <Link to={`/todos/${todo.id}/edit`} className="btn btn-warning">Edit</Link>
        <button onClick={handleDelete} className="btn btn-danger">Delete</button>
        <Link to="/todos" className="btn btn-secondary">Back to Todos</Link>
      </div>
    </div>
  );
};

export default TodoShow;