'use strict';

class ResponseError extends Error 
{
	constructor(code, message, status, info)
	{
		super(message);	
		this.code = code;
		this.status = status;
		this.info = info;
	}
	
	toJSON()
	{
		let ret =
		{
			code: this.code, 
			message: this.message, 
			info: this.info
		};
		return ret;
	}
};

class FORBIDDEN extends ResponseError 
{
	constructor(info)
	{
		super("FORBIDDEN", "Acesso Negado", 403, info);	
	}
};

class UNAUTHORIZED extends ResponseError 
{
	constructor(info)
	{
		super("UNAUTHORIZED", "Usuário não autenticado", 401, info);	
	}
};


class INVALID_USER_ENTRY extends ResponseError 
{
	constructor(info)
	{
		super("INVALID_USER_ENTRY", "Entrada de dados inválida", 422, info);	
	}
};

class NO_DATA_FOUND extends ResponseError 
{
	constructor(info)
	{
		super("NO_DATA_FOUND", "Dados não encontrados", 400, info);	
	}
};

class INVALID_CREDENTIALS extends ResponseError 
{
	constructor(info)
	{
		super("INVALID_CREDENTIALS", "Usuário ou senha incorretos", 401, info);	
	}
};


class INTERNAL_SERVER_ERROR extends ResponseError 
{
	constructor(info)
	{
		super("INTERNAL_SERVER_ERROR", "Ocorreu um erro interno no servidor", 500, info);	
	}
};

module.exports = {ResponseError, FORBIDDEN, UNAUTHORIZED, NO_DATA_FOUND, INVALID_CREDENTIALS, INVALID_USER_ENTRY, INTERNAL_SERVER_ERROR}