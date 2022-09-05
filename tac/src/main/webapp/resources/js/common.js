const loader = document.querySelector('#load');
const html = document.querySelector('html');

html.style.overflow = 'hidden'; //로딩 중 스크롤 방지

window.addEventListener('load', ()=>{

     setTimeout(() => { //로딩속도 구현
    
        loader.style.opacity = '0';
        html.style.overflow = 'auto'; //스크롤 방지 해제        
        setTimeout(() => {
          loader.style.display = 'none';
        }, 100);
        
     }, 100);
})