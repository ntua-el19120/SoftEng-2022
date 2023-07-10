import React, { useState, useEffect, useRef } from 'react';
import axios from 'axios';
import './index.css';
import { nanoid } from "nanoid";

function Questionnaire() {
  //QUESTIONNAIRE 
  const [qids, setQids] = useState([]);
  const [qstnre, setQstnre] = useState([]);
  const isMounted = useRef(false);
  const isMounted2 = useRef(false);
  const isMounted0 = useRef(false);

  const [sessionID, setSessionID] = useState([]);
  const [questionnaireID, setQuestionnaireID] = useState([]);

  useEffect(() => {
    const queryParameters = new URLSearchParams(window.location.search)
    setQuestionnaireID(parseInt(queryParameters.get("QuestionnaireID"), 10));
    const sessid = nanoid(4);
    setSessionID(sessid);
  }, []);

  useEffect(() => {
    if(isMounted0.current && !isNaN(questionnaireID)){
    axios.get(`http://localhost:9103/intelliq_api/questionnaire/${questionnaireID}`)
    .then(response => {
      setQstnre(response.data);
    })
    .catch(error => {
      console.log(error);
    });}
    else isMounted0.current=true;
  }, [questionnaireID]);

  const keywrds = [];
  {qstnre.keywords?.map(kwrd => keywrds.push(kwrd.keyword+" "))}

  //QUESTION  
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState([]);
  const [qstion, setQstion] = useState([]);

  useEffect(() => {

    if(isMounted.current){
      let newQids = [];
      {qstnre.questions?.map(q => newQids.push(q.qID))}
      setQids(newQids);}
    else isMounted.current=true;
  },[qstnre]);

  useEffect(() => {
    if (qids) {
      setCurrentQuestionIndex(qids.shift());
    }
  }, [qids]);

  useEffect(() => {
  if(isMounted2.current) {    
    let url=`http://localhost:9103/intelliq_api/question/${questionnaireID}/${currentQuestionIndex}`;
    if(currentQuestionIndex != undefined){
      axios.get(url)
      .then(response => {
        setQstion(response.data);
        })
      .catch(error => {
        console.log(error);
      });
    }}
    else isMounted2.current=true;
}, [currentQuestionIndex]);




  const opts = [];
  const optids = [];
  const optnexts = [];
  {qstion.options?.map(op => opts.push(op.opttxt))}
  {qstion.options?.map(op => optids.push(op.optID))}
  {qstion.options?.map(op => optnexts.push(op.nextqID))}

  const [hasClicked, setHasClicked] = useState(false);
  //OPTIONS
  const [options, setOptions] = useState([]);
  const handleChange = (e) => {
    const newOptions = {...options};
    Object.keys(newOptions).forEach(key => {
      if (key !== e.target.name) {
        newOptions[key] = false;
      }
    });
    newOptions[e.target.name] = e.target.checked;
    if(e.target.checked === true) setHasClicked(true);
    else setHasClicked(false);
    setOptions(newOptions);
  };

  const handleOnClick = (e) => {
    e.preventDefault();
    let selectedNextQID;
    handleChange(e);
    if(hasClicked){
      const selectedOpt = Object.keys(options).find(key => options[key] === true);
      let selectedOptID = optids[selectedOpt];
      let url=`http://localhost:9103/intelliq_api/doanswer/${questionnaireID}/${currentQuestionIndex}/${sessionID}/${selectedOptID}`;
      axios.post(url);
      selectedNextQID = optnexts[selectedOpt];
    }
    else{
      selectedNextQID = parseInt(currentQuestionIndex)+1;
      if(qids.length < selectedNextQID) selectedNextQID = null;
    }
    setCurrentQuestionIndex(selectedNextQID);
  }

  useEffect(() => {
    setOptions(optids.reduce((acc, curr) => {
        acc[curr] = false;
        return acc;
    }, {}));
}, []);

  if(isNaN(questionnaireID)) return(<h1>Welcome to intelliQ!</h1>);
  else  if(currentQuestionIndex != null){
    return(       
      <div className="wrapper">
        <h1 key={qstnre.questionnaireTitle}><strong>{qstnre.questionnaireTitle}</strong>
        </h1>
        <h3><strong>Keywords: </strong>{keywrds.map((kwd, idx) => (keywrds[idx]))} </h3>

        <form>
          <fieldset>
            <label>
              <p><strong>{qstion.required === "True" ? <label>*</label> : null}{qstion.qtext}</strong></p>
            </label>
          </fieldset>

          <div>
              {opts.map((opt, idx) => (
                <fieldset>
                <label key={idx}>
                  <input
                    type="checkbox"
                    name={idx}
                    onChange={handleChange}
                    checked={options[idx] || false}
                  />
                  {opt}
                </label>
                </fieldset>
              ))}
            </div>
            <button disabled = {(hasClicked || qstion.required === "False") ? false : true} onClick={(e) => handleOnClick(e)}>Next </button>
        </form>
      </div>
      );}
  else
    return(<div>Thank you for submitting! Your sessionID was: {sessionID}</div>)
  }

export default Questionnaire;
