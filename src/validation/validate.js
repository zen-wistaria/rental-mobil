const validate = (schema, request) => {
    const result = schema.validate(request, {
        abortEarly: false,
        allowUnknown: false,
    });

    if (result.error) {
        return result;
    } else {
        return result.value;
    }
};

export default validate;
