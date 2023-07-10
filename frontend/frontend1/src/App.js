import './App.css';
import Questionnaire from './webpages/questionnaire_web';
import MyPieChart from './webpages/graph_web';
import { BrowserRouter as Router, Routes, Route}
    from 'react-router-dom';

function App() {
  return (
    <Router>
    <Routes>
        <Route exact path='/' element={<Questionnaire />} />
        <Route path='/graph' element={<MyPieChart/>} />
    </Routes>
    </Router>
);
}

export default App;