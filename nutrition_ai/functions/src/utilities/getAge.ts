export const getAge = (birthday: Date,) => {

    const ageDifferenceMs = Date.now() - birthday.getTime(),
        ageDate = new Date(ageDifferenceMs,);
    return Math.abs(ageDate.getUTCFullYear() - 1970,);

};
