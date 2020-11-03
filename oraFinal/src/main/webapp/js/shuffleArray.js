// Array의 prototype을 지정해주고, shuffle이라는 이름을 가진 함수를 생성
Array.prototype.shuffle = function () {
    let length = this.length;
    
    // 아래에서 length 후위 감소 연산자를 사용하면서 결국 0이된다.
    // 프로그래밍에서 0은 false를 의미하기에 0이되면 종료.
    while (length) {
 
        // 랜덤한 배열 index 추출
        const index = Math.floor((length--) * Math.random());
 
        // 배열의 끝에서부터 0번째 아이템을 순차적으로 대입
        const temp = this[length];
 
        // 랜덤한 위치의 값을 맨뒤(this[length])부터 셋팅
        this[length] = this[index];
 
        // 랜덤한 위치에 위에 설정한 temp값 셋팅
        this[index] = temp;
    }
 
    // 배열을 리턴해준다.
    return this;
};
