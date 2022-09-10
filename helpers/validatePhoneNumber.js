const validatePhoneNumber = (phoneNumber) => {

    
    if (phoneNumber === undefined){
        console.log('number is undefined')
        return false;
    }

    //trim away white spaces
    const trimmedPhoneNumber = phoneNumber.trim()

    console.log('phoneNumber.length', trimmedPhoneNumber.length)
    if (trimmedPhoneNumber.length != 10) {
        console.log('number is less than 10 digit')
        return false;
    };

    console.log('passed test 1')
    for (let element of trimmedPhoneNumber) {
        console.log(parseInt(element))
        console.log('parseInt(element)', parseInt(element))
        if (parseInt(element) === 0) {
            element += 1
        }

        if (!parseInt(element)) {
            console.log('return false now')
            return false;
        }
    };
    console.log('passed test 2')
    return true;
}

module.exports = { validatePhoneNumber };