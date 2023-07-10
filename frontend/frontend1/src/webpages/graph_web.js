import React, { useReducer, useState, useEffect, useRef } from 'react';
import axios from 'axios';
import './index.css';
import { VictoryPie, VictoryChart, VictoryGroup, VictoryBar, VictoryTheme, VictoryHistogram, VictoryAxis } from 'victory';
import chroma from "chroma-js";


function generateColorScale(n) {
  return chroma.scale(["tomato", "orange", "gold", "cyan", "navy"]).colors(n);
}

export default function MyPieChart() {

  const isMounted = useRef(false);
  const isMounted2 = useRef(false);
  const isMounted0 = useRef(false);

  //QUESTIONNAIRE 
  const [qids, setQids] = useState([]);
  const [qstnre, setQstnre] = useState([]);

  const [questionnaireID, setQuestionnaireID] = useState([]);

  useEffect(() => {
    const queryParameters = new URLSearchParams(window.location.search)
    setQuestionnaireID(parseInt(queryParameters.get("QuestionnaireID"), 10));
  }, []);

  useEffect(() => {
    if(isMounted0.current){
    axios.get(`http://localhost:9103/intelliq_api/questionnaire/${questionnaireID}`)
    .then(response => {
      setQstnre(response.data);
    })
    .catch(error => {
      console.log(error);
    });}
    else isMounted0.current=true;
  }, [questionnaireID]);
  //QUESTION  
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState([]);
  const [qstion, setQstion] = useState([]);

  useEffect(() => {
    if(isMounted2.current){
      let newQids = [];
      {qstnre.questions?.map(q => newQids.push(q.qID))}
      setQids(newQids);}
    else isMounted2.current=true;
  },[qstnre]);

  useEffect(() => {
    if (qids) {
      setCurrentQuestionIndex(qids[0]);
    }
  }, [qids]);

  useEffect(() => {
    if(isMounted.current){
      if(currentQuestionIndex != undefined){
        let url=`http://localhost:9103/intelliq_api/getquestionanswersenhanced/${questionnaireID}/${currentQuestionIndex}`;
        axios.get(url)
        .then(response => {
          setQstion(response.data);
          })
        .catch(error => {
          console.log(error);
        });
    }
  }
    else isMounted.current=true;
}, [currentQuestionIndex]);

  const answrs = [];
  {qstion.answers?.map(ans => answrs.push(ans.answer_txt))}

  const handleOnClick = (e) => {
    e.preventDefault();
    let selectedNextQID;
    selectedNextQID = parseInt(currentQuestionIndex)+1;
    if(qids.length < selectedNextQID) selectedNextQID = null;
    setCurrentQuestionIndex(selectedNextQID);
  }

//unique answertxt = key, number of times = value 
  let count = answrs.reduce(function(acc, curr) {
    acc[curr] = acc[curr] ? acc[curr] + 1 : 1;
    return acc;
  }, {});
  const ansData = Object.entries(count).map(([x, y]) => ({ x, y }));

  if(currentQuestionIndex !== null){
    return (
      <div className="wrapper">
        <h1 key={qstnre.questionnaireTitle}><strong>{qstnre.questionnaireTitle}</strong></h1>
        <fieldset>
          <label>
            <p><strong>{qstion.qtext}</strong></p>
          </label>
        </fieldset>

        <div style={{width: '1000px', height: '200px', overflow: 'hidden'}}>
          <VictoryPie
            animate={{
              duration: 1000
            }}
            tooltip={"dshv"}
            colorScale={generateColorScale(ansData.length)}
            data={ansData}
          />
        </div>
        <button  onClick={(e) => handleOnClick(e)}>Next </button>
        </div>
    );
  }
  else return (<div>That's all.</div>);
}
